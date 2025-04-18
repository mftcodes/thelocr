import { useNavigate } from "react-router-dom";
import Button from "../components/Button";
import Container from "react-bootstrap/esm/Container";
import Col from "react-bootstrap/Col";

export default function Landing() {
  let navigate = useNavigate();
  const goToSearch = () => {
    navigate("/search");
  }

  return (
    <>
      <h2 className="text-center search pb-3">Welcome to The LOCR</h2>
      <Container className="text-center">
        <p>
          The <strong>L</strong>ibrary of <strong>O</strong>nline <strong>
          C</strong>ommunity<strong> R</strong>esources is a citizen 
          driven and maintained Community Resource Repository.
        </p>
        <p>
          The LOCR is working toward a <em>One-Stop-Shop</em> site to find the community based
          non-profits, organizations, and services working to help any and all in need of assistance.
          Find food banks, mental health providers, legal aid, and more.
        </p>
        <Col className="text-center pt-3">
          <Button type="thelocr btn_thelocr__alt" doClick={() => goToSearch()} className="text-center">
            Go find a resource
          </Button>
         </Col>
      </Container>
    </>
  );
}
