import wrap from '@graphql-tools/wrap';
import stitch from '@graphql-tools/stitch';
import crossFetch from 'cross-fetch';
import graphql from 'graphql';
import batchDelegate from '@graphql-tools/batch-delegate';

const introspectSchema = wrap.introspectSchema;
const stitchSchemas = stitch.stitchSchemas;
const fetch = crossFetch.fetch;
const print = graphql.print;
const batchDelegateToSchema = batchDelegate.batchDelegateToSchema;

async function productRemoteExecutor({ document, variables }) {
  const query = print(document);
  const fetchResult = await fetch('http://localhost:3000/graphql', {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify({ query, variables }),
  });
  return fetchResult.json();
}

async function imageRemoteExecutor({ document, variables }) {
  const query = print(document);
  const fetchResult = await fetch('http://localhost:4000/', {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify({ query, variables }),
  });
  return fetchResult.json();
}

export const productSubschema = {
  schema: await introspectSchema(productRemoteExecutor),
  executor: productRemoteExecutor,
};

export const imageSubschema = {
  schema: await introspectSchema(imageRemoteExecutor),
  executor: imageRemoteExecutor,
  merge: {
    Image: {
      selectionSet: '{ id }',
      fieldName: 'images',
      key: ({ id }) => id,
      agesFromKeys: (ids) => ({ ids })
    }
  }
};

export const gatewaySchema = stitchSchemas({
  subschemas: [
    productSubschema,
    imageSubschema,
  ],
  typeDefs: `
    extend type ProductImage {
      image: Image!
    }
  `,
  resolvers: {
    ProductImage: {
      image: {
        selectionSet: `{ imageId }`,
        resolve(productImage, args, context, info) {
          return batchDelegateToSchema({
            schema: imageSubschema,
            operation: 'query',
            fieldName: 'images',
            key: productImage.imageId,
            argsFromKeys: (ids) => ({ ids }),
            context,
            info,
          });
        },
      },
    },
  }
});
