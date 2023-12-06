#!/usr/bin/python3

"""
Fabric script that generates a .tgz archive from the contents of the web_static
"""
from datetime import datetime
from fabric.api import local
import os


def do_pack():
    """
    function that creates tgz archive from a given directory
    """
    source = "web_static2"
    timestamp = datetime.now().strftime('%Y%m%d%H%M%S')
    archive_name = f'web_static_{timestamp}.tgz'
    target_folder = f'versions'
    local(f'mkdir -p {target_folder}')
    result = local(f'tar -vczf versions/{archive_name} -C {source} .',
                   capture=True)
    archive_path = f'{os.getcwd}/{target_folder}'

    if result.succeeded:
        return archive_path
    else:
        return None
