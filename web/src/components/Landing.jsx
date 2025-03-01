import { useNavigate } from "react-router-dom";
import Button from "./Button";
import Container from "react-bootstrap/esm/Container";

export default function Landing() {
  let navigate = useNavigate();
  const routeChange = () => {
    navigate("/search");
  }

  return (
    <>
      <h2 className="text-center search pb-3">Welcome to Project Bowen</h2>
      <Container>
        <p>A citizen driven and maintained Community Resource Repository.</p>
        <p>
          With the increasing challenges of the Climate Crisis, the reduction in
          funding for public services for those in need and at risk, and the
          quickly changing landscape of politics, we are seeing organizations
          come and go more quickly. Maybe someone needs housing today, and the
          shelter that you used to refer them too has closed, where do you go?
          Maybe a family is need of some free legal aid to help them maintain
          their residency status, and the legal office down the street has
          shuttered, so where does this family go? Our hope that the answer
          becomes Project Bowen.
        </p>
        <p>
          There are services like 211 across the country that serve a similar
          functions, and are maintained by organization like The United Way.
          Project Bowen is not intended to replace these services, rather be an
          addition to. The big difference is in function. Project Bowen
          champions Social Workers, community leaders and organizers, citizen,
          and anyone anyone else to come and add the resources you know about in
          your community, and update the ones that resources that have changed.
        </p>
        <p>
          It is our hope that this becomes the base building block to begin
          addressing these problem, and is but a small piece of a much larger
          road map.
        </p>
        <Button type="bowen" doClick={() => routeChange()}>
          Go find a resource
        </Button>
      </Container>
    </>
  );
}
