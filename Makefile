
PELICAN=pelican
PELICANOPTS=None

BASEDIR=$(PWD)
INPUTDIR=$(BASEDIR)/content
OUTPUTDIR=$(BASEDIR)/output
CONFFILE=$(BASEDIR)/pelican.conf.py

DEPLOY_TMP_DIR=/tmp/amara_dev_blog

FTP_HOST=localhost
FTP_USER=anonymous
FTP_TARGET_DIR=/

S3_BUCKET=labs.amara.org
SSH_HOST=locahost
SSH_USER=root
SSH_TARGET_DIR=/var/www

DROPBOX_DIR=~/Dropbox/Public/

help:
	@echo 'Makefile for a pelican Web site                                       '
	@echo '                                                                      '
	@echo 'Usage:                                                                '
	@echo '   make html                        (re)generate the web site         '
	@echo '   make clean                       remove the generated files        '
	@echo '   ftp_upload                       upload the web site using FTP     '
	@echo '   ssh_upload                       upload the web site using SSH     '
	@echo '   dropbox_upload                   upload the web site using Dropbox '
	@echo '                                                                      '


html: clean $(OUTPUTDIR)/index.html
	@echo 'Done'

$(OUTPUTDIR)/%.html:
	$(PELICAN) $(INPUTDIR) -o $(OUTPUTDIR) -s $(CONFFILE)

clean:
	rm -fr $(OUTPUTDIR)
	mkdir $(OUTPUTDIR)

dropbox_upload: $(OUTPUTDIR)/index.html
	cp -r $(OUTPUTDIR)/* $(DROPBOX_DIR)

ssh_upload: $(OUTPUTDIR)/index.html
	scp -r $(OUTPUTDIR)/* $(SSH_USER)@$(SSH_HOST):$(SSH_TARGET_DIR)

deploy: $(OUTPUTDIR)/index.html
	ssh -p 2191 $(SSH_USER)@dev.amara.org "mkdir -p $(DEPLOY_TMP_DIR)"
	scp -P 2191 -r $(OUTPUTDIR)/* $(SSH_USER)@dev.amara.org:$(DEPLOY_TMP_DIR)/
	ssh -p 2191 -t $(SSH_USER)@dev.amara.org "sudo s3cmd -c /etc/s3cfg --recursive put $(DEPLOY_TMP_DIR)/* s3://$(S3_BUCKET)/ ; rm -rf $(DEPLOY_TMP_DIR)"

ftp_upload: $(OUTPUTDIR)/index.html
	lftp ftp://$(FTP_USER)@$(FTP_HOST) -e "mirror -R $(OUTPUT_DIR)/* $(FTP_TARGET_DIR) ; quit"

github: $(OUTPUTDIR)/index.html
	ghp-import $(OUTPUTDIR)
	git push origin gh-pages

.PHONY: html help clean ftp_upload ssh_upload dropbox_upload github

