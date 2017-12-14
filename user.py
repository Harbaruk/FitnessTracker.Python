# -*- coding: utf-8 -*-
"""
Created on Thu Nov 23 10:29:28 2017

@author: XXX
"""
from flask import Flask
from flask import request
from flask import jsonify
from db import dbconnection

class User:
    @staticmethod
    @app_route('api/user/checkAuth', methods = ['POST'])
    def checkAuth():
         data = request.get_json()
         userId = data['userId']
         token = data['token']
         
         return jsonify({'status': 0, 'message': 'Ok'});
        