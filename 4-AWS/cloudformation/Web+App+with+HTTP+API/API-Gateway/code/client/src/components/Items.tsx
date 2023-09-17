import dateFormat from 'dateformat'
import { History } from 'history'
import update from 'immutability-helper'
import * as React from 'react'
import {
  Button,
  Checkbox,
  Container,
  Divider,
  Grid,
  Header,
  Icon,
  Input,
  Image,
  Loader
} from 'semantic-ui-react'

import { createItem, deleteItem, getItems, patchItem } from '../api/items-api'
import { Item } from '../types/Item'

interface ItemsProps {
  history: History
}

interface ItemsState {
  items: Item[]
  newItemItemId: string
  newItemName: string
  newItemPrice: string
  loadingItems: boolean
}

export class Items extends React.PureComponent<ItemsProps, ItemsState> {
  state: ItemsState = {
    items: [],
    newItemItemId: '',
    newItemName: '',
    newItemPrice: '',
    loadingItems: true
  }

  handleItemIdChange = (event: React.ChangeEvent<HTMLInputElement>) => {
    this.setState({ newItemItemId: event.target.value })
  }

  handleNameChange = (event: React.ChangeEvent<HTMLInputElement>) => {
    this.setState({ newItemName: event.target.value })
  }

  handlePriceChange = (event: React.ChangeEvent<HTMLInputElement>) => {
    this.setState({ newItemPrice: event.target.value })
  }

  onItemCreate = async () => {
    try {
      const newItem = await createItem( {
        itemId: this.state.newItemItemId,
        name: this.state.newItemName,
        price: this.state.newItemPrice
      })
      const items = await getItems()
      this.setState({
        items,
        loadingItems: false
      })
    } catch {
      alert('Item creation failed')
    }
  }

  onItemDelete = async (itemId: string) => {
    try {
      await deleteItem(itemId)
      const items = await getItems()
      this.setState({
        items,
        loadingItems: false
      })
    } catch {
      alert('Item deletion failed')
    }
  }

  async componentDidMount() {
    try {
      const items = await getItems()
      this.setState({
        items,
        loadingItems: false
      })
    } catch (e) {
      alert(`Failed to fetch items: ${e.message}`)
    }
  }

  render() {
    return (
      <div>
          <Header as="h1">ITEMs</Header>

          {this.renderCreateItemInput()}

          {this.renderItems()}
      </div>
    )
  }

  renderCreateItemInput() {
    return (
      <Grid.Row>
        <Grid.Column width={8}>

          <Input
            fluid
            actionPosition="left"
            placeholder="Item Id..."
            onChange={this.handleItemIdChange}
          />

          <Input
            fluid
            actionPosition="left"
            placeholder="Item name..."
            onChange={this.handleNameChange}
          />

          <Input
            fluid
            actionPosition="left"
            placeholder="Item price - like $10.00 ..."
            onChange={this.handlePriceChange}
          />

          <Button
            color="teal"
            content="Add New Item"
            icon="add"
            onClick={this.onItemCreate}
          />
        </Grid.Column>
        <Grid.Column width={16}>
          <Divider />
        </Grid.Column>
      </Grid.Row>
    )
  }

  renderItems() {
    if (this.state.loadingItems) {
      return this.renderLoading()
    }

    return this.renderItemsList()
  }

  renderLoading() {
    return (
      <Grid.Row>
        <Loader indeterminate active inline="centered">
          Loading ITEMs
        </Loader>
      </Grid.Row>
    )
  }

  renderItemsList() {
    return (
      <Grid padded>
        <Grid.Row key={0}>
          <Grid.Column width={3} verticalAlign="middle">
            Item Id
          </Grid.Column>
          <Grid.Column width={5} verticalAlign="middle">
            Name
          </Grid.Column>
          <Grid.Column width={4} floated="right">
            Price
          </Grid.Column>
          <Grid.Column width={1} floated="right">
          </Grid.Column>
          <Grid.Column width={16}>
            <Divider />
          </Grid.Column>
        </Grid.Row>
        {this.state.items.map((item, pos) => {
          return (
            <Grid.Row key={item.itemId}>
              <Grid.Column width={3} verticalAlign="middle">
                {item.itemId}
              </Grid.Column>
              <Grid.Column width={5} verticalAlign="middle">
                {item.name}
              </Grid.Column>
              <Grid.Column width={4} floated="right">
                {item.price}
              </Grid.Column>
              <Grid.Column width={1} floated="right">
                <Button
                  icon
                  color="red"
                  onClick={() => this.onItemDelete(item.itemId)}
                >
                  <Icon name="delete" />
                </Button>
              </Grid.Column>
              <Grid.Column width={16}>
                <Divider />
              </Grid.Column>
            </Grid.Row>
          )
        })}
      </Grid>
    )
  }

}
