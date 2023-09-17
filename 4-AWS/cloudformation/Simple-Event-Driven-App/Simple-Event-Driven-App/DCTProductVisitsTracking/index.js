'use strict'

const AWS = require('aws-sdk')
const uuidv4 = require('uuid/v4')

AWS.config.update({ region: process.env.Region, apiVersion: '2012-08-10' })

const docClient = new AWS.DynamoDB.DocumentClient()

module.exports.handler = async (event) => {
    
    console.log('Received event:', JSON.stringify(event, null, 2));

    const allPromises = event.Records.map(async (record) => {
        let { body } = record;

        console.log(body);
        
        body = JSON.parse(body);

        try {

            const { ProductId, ProductName, Category, PricePerUnit, CustomerId, CustomerName, TimeOfVisit } = body;
            
            if (!ProductId || !ProductName || !Category || !PricePerUnit || !CustomerId || !CustomerName || !TimeOfVisit) {
                console.log('Please provide values for product, category, customer and time of visit.');
            }

            body.ProductVisitKey = uuidv4();

            console.log(`${body.ProductVisitKey} ${ProductId} ${ProductName} ${Category} ${PricePerUnit} ${CustomerId} ${CustomerName} ${TimeOfVisit}`);

            const params = {
                TableName: 'ProductVisits',
                Item: body
            }
            await docClient.put(params).promise();

            console.log('Product Visit record is successfully created.');

        } catch (err) {
            console.error(err.message);
            console.error(err);
        }

    });

    await Promise.all(allPromises);

    return {}
}