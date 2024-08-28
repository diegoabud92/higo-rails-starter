// Run this example by adding <%= javascript_pack_tag 'hello_react' %> to the head of your layout file,
// like app/views/layouts/application.html.erb. All it does is render <div>Hello React</div> at the bottom
// of the page.

import React from 'react'
import { Switch, Route } from 'react-router-dom'

import { useApplicationProvider } from '../providers/ApplicationProvider.jsx'

import Home from 'pages/Home.jsx'
import About from 'pages/About.jsx'

const ApplicationRoutes = props => (
  <Switch>
    <Route path="/" exact={true}><Home /></Route>
    <Route path="/about"><About /></Route>
  </Switch>
)

export default ApplicationRoutes
