import { useNavigate } from "react-router-dom";
import Button from "../components/Button";
import Container from "react-bootstrap/esm/Container";
import Col from "react-bootstrap/Col";

export default function support() {
  let navigate = useNavigate();
  const goToSearch = () => {
    navigate("/search");
  }

  return (
    <>
      <Container className="text-center">
      <h1 className="text-center">Support</h1>
        <p>
          If you need suport please <a href="mailto:hello@jeffconsults.llc">email</a> us.
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
