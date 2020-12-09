import express from 'express';
import graphql from 'express-graphql';
import { gatewaySchema } from './schema.js';

const graphqlHTTP = graphql.graphqlHTTP;

const app = express();
app.use('/graphql', graphqlHTTP({ schema: gatewaySchema }));
app.listen(5000, () => console.info('Listening on http://localhost:5000/graphql'));
