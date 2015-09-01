#!/bin/env python3
import os
import tempfile
import logging

import requests
import mysql.connector

def downloaducd():
    """Downloads UnicodeData.txt from unicode.org

    Returns the filename of the downloaded file
    """
    ucd_url = 'http://www.unicode.org/Public/UCD/latest/ucd/UnicodeData.txt'
    ucdfn = tempfile.mkstemp(suffix='ucd')[1]
    with open(ucdfn, 'wb') as fh:
        logging.info('Downloading UnicodeData.txt contents to %s', ucdfn)
        fh.write(requests.get(ucd_url).content)
    return ucdfn

def loaducd(conn, ucdfn):
    """Loads UnicodeData.txt into the database

    Format description:
    http://www.unicode.org/reports/tr44/tr44-16.html#UnicodeData.txt
    """
    logging.info('Creating database schema for unicodedata')
    cur = conn.cursor()
    cur.execute('DROP DATABASE IF EXISTS unicodedata')
    cur.execute('CREATE DATABASE unicodedata')
    conn.set_database('unicodedata')

    cur.execute("""
CREATE TABLE ucd (
  value VARCHAR(6) NOT NULL,
  name VARCHAR(100),
  category ENUM('Cc','Cf','Co','Cs','Ll','Lm','Lo','Lt','Lu','Mc','Me','Mn','Nd','Nl','No','Pc','Pd','Pe','Pf','Pi','Po','Ps','Sc','Sk','Sm','So','Zl','Zp','Zs') NOT NULL,
  combining_class VARCHAR(20),
  bidi_class ENUM('AL','AN','B','BN','CS','EN','ES','ET','FSI','L','LRE','LRI','LRO','NSM','ON','PDF','PDI','R','RLE','RLI','RLO','S','WS') NOT NULL,
  decomposition VARCHAR(100),
  numeric1 VARCHAR(20),
  numeric2 VARCHAR(20),
  numeric3 VARCHAR(20),
  bidi_mirrored ENUM('N','Y') NOT NULL,
  unicode1_name VARCHAR(100),
  ISO_comment CHAR(0),
  uppercase_mapping VARCHAR(5),
  lowercase_mapping VARCHAR(5),
  titlecase_mapping VARCHAR(5)
) DEFAULT CHARACTER SET latin1""")

    logging.info('Loading data from %s into the unicodedata.ucd table', ucdfn)
    cur.execute("LOAD DATA LOCAL INFILE %s INTO TABLE ucd FIELDS TERMINATED BY ';'", (ucdfn,))

    logging.info('Adding column for the real character')
    cur.execute("ALTER TABLE ucd ADD COLUMN `char` CHAR(4) CHARACTER SET utf8mb4 AFTER value")

    logging.info('Setting the char column to the real character based on the value')
    cur.execute("UPDATE ucd SET `char`=CONVERT(UNHEX(value) USING utf32)")
    cur.close()
    conn.commit()

if __name__ == "__main__":
    logging.basicConfig(level=logging.INFO)
    connarg = {
        'user': 'msandbox',
        'password': 'msandbox',
        'unix_socket': '/tmp/mysql_sandbox5708.sock',
        'charset': 'utf8mb4',
        'allow_local_infile': True
    }
    conn = mysql.connector.connect(**connarg)
    ucdfn = downloaducd()
    loaducd(conn, ucdfn) 
    conn.close()
    os.unlink(ucdfn)

    print("The data is loaded into unicodedata.ucd")  
    print("Don't forget to do SET NAMES utf8mb4 or set your connection properties to utf8mb4")
