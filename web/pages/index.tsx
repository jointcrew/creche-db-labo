import type { NextPage } from "next";
import { Informations } from "../components/Informations";

const Home: NextPage = () => {
  return (
    <div style={{ padding: 20 }}>
      <h2>Home</h2>
      <Informations />
    </div>
  );
};

export default Home;
