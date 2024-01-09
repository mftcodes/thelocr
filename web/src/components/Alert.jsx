import { ReactNode } from "react";

// 'children' is a keyword in react that allows passing in child html.
const Alert = ({ children, type, onClose }) => {
  return (
    <>
      <div
        className={`alert alert-${type} alert-dismissible fade show`}
        role="alert"
      >
        {children}
        <button
          type="button"
          className="btn-close"
          data-dismiss="alert"
          aria-label="Close"
          onClick={onClose}
        />
      </div>
    </>
  );
};

export default Alert;
