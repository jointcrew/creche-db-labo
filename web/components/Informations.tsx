import { gql, useQuery } from "@apollo/client";

const GET_INFORMATION_QUERY = gql`
  query GetInformations {
    informations {
      id
      title
      content
      published_at
    }
  }
`;

type GetInformationsResponse = {
  informations: {
    id: number;
    title: string;
    content: string;
    published_at: string;
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
              {info.title} / {info.published_at}
            </li>
          ))}
      </ul>
    </div>
  );
};
