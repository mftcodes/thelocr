import { useNavigate } from "react-router-dom";
import Button from "../components/Button";
import Container from "react-bootstrap/esm/Container";
import Col from "react-bootstrap/Col";

export default function About() {
  let navigate = useNavigate();
  const goToSearch = () => {
    navigate("/search");
  }

  return (
    <>
      <Container className="text-center">
      <h1 className="text-center">About The LOCR</h1>
        <p>
          The <strong>L</strong>ibrary of <strong>O</strong>nline <strong>
          C</strong>ommunity<strong> R</strong>esources is a citizen 
          driven and maintained Community Resource Repository.
        </p>
        <p>
          With the increasing challenges of the Climate Crisis, the reduction in
          funding for public services for those in need and at risk, and the
          quickly changing landscape of politics, we are seeing organizations
          come and go more quickly. Maybe someone needs housing today, and the
          shelter that you used to refer them too has closed, where do you go?
          Maybe a family is need of some free legal aid to help them maintain
          their residency status, and the legal office down the street has
          shuttered, so where does this family go? We hope the answer
          becomes The <strong>L</strong>ibrary of <strong>O</strong>nline <strong>
          C</strong>ommunity<strong> R</strong>esources (<strong>The LOCR</strong>).
        </p>
        <p>
          There are services like 211 across the country that serve a similar
          functions, and are maintained by organization like The United Way.
          The LOCR is not intended to replace these services, rather be an
          addition to. The difference is in function. The LOCR champions 
          social workers, community leaders and organizers, citizen, and 
          anyone else to come and add the resources they know about in the 
          community, and update the resources that have changed.
        </p>
        <p>
          It is our hope that this becomes the base building block to begin
          addressing these problem, and a small beginning of a much larger
          road map.
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
