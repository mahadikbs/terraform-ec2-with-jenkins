#!/bin/bash
sudo systemctl daemon-reload
sudo systemctl enable prometheus
sudo systemctl restart prometheus

