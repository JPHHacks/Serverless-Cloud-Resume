import React from "react";
import Container from "react-bootstrap/Container";

const Footer = (props) => {
  const bgStyle = { backgroundColor: "#f5f5f5", padding: "20px 0" };

  return (
    <footer style={bgStyle} className="mt-auto text-center">
      <Container>
        {props.children}
        <p>
          <a
            rel="noopener"
            href="https://github.com/JPHHacks"
            aria-label="My GitHub"
            className="badge bg-dark"
            style={{ fontWeight: "bold" }}
          >
            JP Heymann
          </a>
        </p>
        <p>
          <small className="text-muted">
            This website is powered by <i className="fab fa-react" /> and hosted on <i className="fab fa-aws" />.
          </small>
        </p>
        <p>
          <small>&copy; 2024 JP Heymann. All Rights Reserved.</small>
        </p>
      </Container>
    </footer>
  );
};

export default Footer;
