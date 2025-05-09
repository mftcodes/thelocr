import Container from "react-bootstrap/esm/Container";

export default function Privacy() {
  return (
    <>
      <Container className="text-center">
        <h1 className="pb-2">Privacy Policy</h1>
        <section aria-labelledby="analytics-heading">
          <h3 id="analytics-heading">Analytics</h3>
          <p>
            This site uses{" "}
            <a href="https://www.simpleanalytics.com/">Simple Analytics</a> to
            help understand the traffic patterns of users. All data collected by{" "}
            <strong>Simple Analytics</strong> is stripped of identifiable
            information, thus the visitor cannot be identified.
          </p>
          <p>
            You can learn more about Simple Analytics data collection in their{" "}
            <a href="https://dashboard.simpleanalytics.com/privacy-policy">
              Privacy Policy
            </a>
            , statement on{" "}
            <a href="https://dashboard.simpleanalytics.com/no-tracking">
              not tracking you
            </a>
            , and documents summing up the{" "}
            <a href="https://docs.simpleanalytics.com/what-we-collect">
              metrics they collect
            </a>
            .
          </p>
        </section>

        <section aria-labelledby="external-content-heading">
          <h3 id="external-content-heading">External Content</h3>
          <p>
            This site uses <a href="https://auth0.com/">Auth0</a> for login and
            account management. You can review their privacy policy{" "}
            <a href="https://www.okta.com/legal/privacy-policy/">here</a>.
          </p>
          <p>
            When you register, your email address and profile from your choice
            of identify provider (e.g. Google, Microsoft, etc.) is saved within
            the LOCR's tenant database. You can request this be deleted at any
            time by contacting us at{" "}
            <a href="mailto:hello@thelocr.com">Email Us</a>.
          </p>
        </section>

        <section aria-labelledby="hosting-heading">
          <h3 id="hosting-heading">Hosting and Infrastructure</h3>
          <p>
            This type of service has the purpose of hosting Data and files that
            enable this website to exist.
          </p>
          <p>
            Some services among those listed below, if any, may work through
            geographically distributed servers, making it difficult to determine
            the actual location where the Personal Data are stored.
          </p>

          <h5>DigitalOcean</h5>
          <p>
            The site is hosted with DigitalOcean, and you care review their
            privacy policy{" "}
            <a href="https://www.digitalocean.com/legal/privacy-policy">here</a>
            .
          </p>
        </section>
      </Container>
    </>
  );
}
