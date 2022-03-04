import { gql, useQuery } from "@apollo/client";

const GET_INFORMATION_QUERY = gql`
  query GetInformations {
    informations {
      id
      title
      content
      publishedAt
    }
  }
`;

type GetInformationsResponse = {
  informations: {
    id: number;
    title: string;
    content: string;
    publishedAt: string;
  }[];
};

export const Informations = () => {
  const { data, error, loading } = useQuery<GetInformationsResponse>(
    GET_INFORMATION_QUERY
  );

  if (loading) {
    return <div>Loading...</div>;
  }

  if (error) {
    return <div>Error</div>;
  }

  return (
    <div>
      <ul>
        {data &&
          data.informations.map((info) => (
            <li key={info.id}>
              {info.title} / {info.publishedAt}
            </li>
          ))}
      </ul>
    </div>
  );
};
