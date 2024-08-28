// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import "channels"
import * as ActiveStorage from "@rails/activestorage"

ActiveStorage.start()

import 'bootstrap/dist/js/bootstrap'
import 'bootstrap/dist/css/bootstrap'

import React from 'react'
import ReactDOM from 'react-dom'

import { BrowserRouter as Router } from 'react-router-dom'

import ApplicationProvider from '../providers/ApplicationProvider.jsx'
import ApplicationRoutes from '../routes/ApplicationRoutes.jsx'

const ReactApp = props => (
  <ApplicationProvider>
    <Router>
      <ApplicationRoutes />
    </Router>
  </ApplicationProvider>
)

document.addEventListener('DOMContentLoaded', () => {
  ReactDOM.render(<ReactApp />, document.getElementById('react-app'))
})
