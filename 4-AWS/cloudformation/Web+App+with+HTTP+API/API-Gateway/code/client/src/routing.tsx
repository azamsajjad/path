import React from 'react'
import { Router, Route } from 'react-router-dom'
import createHistory from 'history/createBrowserHistory'
import App from './App';
const history = createHistory()


export const makeRouting = () => {
  return (
    <Router history={history}>
      <div>
        <Route
          render={props => {
            return <App {...props} />
          }}
        />
      </div>
    </Router>
  )
}
