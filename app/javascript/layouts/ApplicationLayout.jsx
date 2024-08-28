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

import { Link } from 'react-router-dom'

import { useApplicationProvider } from '../providers/ApplicationProvider.jsx'

const ApplicationLayout = ({ children }) => {
  const { currentUser } = useApplicationProvider()

  return (
    <>
      <ul>
        <li><Link to="/">Home</Link></li>
        <li><Link to="/about">About</Link></li>

        <li>
          {currentUser ? (
            <a href="/users/sign_out">Sign out</a>
          ) : (
            <a href="/users/sign_in">Sign in</a>
          )}
        </li>
      </ul>

      {children}
    </>
  )
}

export default ApplicationLayout
