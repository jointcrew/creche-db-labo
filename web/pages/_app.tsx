import "../styles/globals.css";
import type { AppProps } from "next/app";
import {
  ApolloClient,
  ApolloProvider,
  from,
  HttpLink,
  InMemoryCache,
} from "@apollo/client";

const httpLink = new HttpLink({
  uri: process.env.HASURA_ENDPOINT,
  headers: {
    "x-hasura-admin-secret": process.env.HASURA_ADMIN_SECRET,
    "content-type": "application/json",
  },
});

const client = new ApolloClient({
  cache: new InMemoryCache(),
  link: from([httpLink]),
});

function MyApp({ Component, pageProps }: AppProps) {
  return (
    <ApolloProvider client={client}>
      <Component {...pageProps} />
    </ApolloProvider>
  );
}

export default MyApp;
