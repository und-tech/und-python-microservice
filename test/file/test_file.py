# -*- coding: utf-8 -*-
"""Test module file"""

from und_microservice.commons.file import File

def test_yml_file():
    """Test read yml file"""
    espected_data = {
        'service': {
            'name': "x",
            'ip': "127.0.0.1",
            'user_name': "user"
        }
    }
    read_data = File.read_yml('test/resources/test_other_file.yml')
    assert espected_data == read_data
