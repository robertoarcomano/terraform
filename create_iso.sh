#!/bin/bash
genisoimage -output cloud_init.iso -volid cidata -joliet -rock user_data.yaml
