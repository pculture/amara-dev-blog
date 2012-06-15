#!/usr/bin/env python
# -*- coding: utf-8 -*- #

AUTHOR = u"Amara Team"
SITENAME = u"Amara Dev Blog"
SITEURL = '/'
THEME = './theme'

TIMEZONE = 'America/New_York'

DEFAULT_LANG='en'

# Blogroll
LINKS =  (
        ('Amara / Universal Subtitles', 'https://universalsubtitles.org/'),
        ('Participatory Culture Foundation', 'http://pculture.org/'),
)

# Social widget
SOCIAL = (
        ('twitter', 'http://twitter.com/amarasubs'),
        ('github', 'http://github.com/pculture/'),
)

DEFAULT_PAGINATION = False
DISPLAY_PAGES_ON_MENU = True
MD_EXTENSIONS = ['codehilite', 'extra', 'toc']

ARTICLE_PERMALINK_STRUCTURE = '%Y-%m-%d'
TWITTER_USERNAME = 'amarasubs'
