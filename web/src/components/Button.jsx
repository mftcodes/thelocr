const Button = ({ type = "primary", children, doClick }) => {
  return (
    <button type="button" className={`btn btn_${type}`} onClick={doClick}>
      {children}
    </button>
  );
};

export default Button;
