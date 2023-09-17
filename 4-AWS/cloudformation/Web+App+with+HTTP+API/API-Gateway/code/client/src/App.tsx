import React, { Component } from 'react'
import { Link, Route, Router, Switch } from 'react-router-dom'
import { Container, Grid, Menu, Segment, Image } from 'semantic-ui-react'

import { NotFound } from './components/NotFound'
import { Items } from './components/Items'

import logo from './DCTLogoSilver3D.png';

export interface AppProps {}

export interface AppProps {
  history: any
}

export interface AppState {}

export default class App extends Component<AppProps, AppState> {
  constructor(props: AppProps) {
    super(props)
  }

  render() {
    return (
      <Container>
        {/* Heads up! We apply there some custom styling, you usually will not need it. */}
        <style>
          {`
          html, body {
            background-color: #003163 !important;
            color: #fff !important;
          }
          h1.ui.header {
            color: #fff !important;
          }
          p > span {
            opacity: 0.4;
            text-align: center;
          }
        }
        `}
        </style>
        <Segment style={{ padding: '2em 0em' }} vertical>
          <Grid container stackable verticalAlign="middle">
            <Grid.Row>
              <Image src={logo} alt='Logo' size='medium' verticalAlign='middle' centered />
            </Grid.Row>
            <Grid.Row>
              <Grid.Column width={16}>
                <Router history={this.props.history}>
                  {this.generateMenu()}

                  {this.generateCurrentPage()}
                </Router>
              </Grid.Column>
            </Grid.Row>
          </Grid>
        </Segment>
      </Container>
    )
  }

  generateMenu() {
    return (
      <Menu>
        <Menu.Item name="items">
          <Link to="/">Items</Link>
        </Menu.Item>
      </Menu>
    )
  }

  generateCurrentPage() {

    return (
      <Switch>
        <Route
          path="/"
          exact
          render={props => {
            return <Items {...props} />
          }}
        />

        <Route component={NotFound} />
      </Switch>
    )
  }
}
