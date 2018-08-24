# -*- coding: utf-8 -*-
"""Test module file"""

from und_microservice.commons.file import File

def test_yml_file():
    """Test read yml file"""
    read_data = File.read_yml('test/resources/test_other_file.yml')
    print(read_data)
    assert True
