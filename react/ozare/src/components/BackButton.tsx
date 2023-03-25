import React from "react";
import { BsArrowLeftShort } from "react-icons/bs";
import { useNavigate } from "react-router-dom";

function BackButton() {
  const navigate = useNavigate();

  const goBack = () => {
    navigate(-1);
  };

  return (
    <button
      onClick={() => goBack()}
      className="text-sky-500 bg-white rounded-full bg-opacity-90 p-2 font-bold text-2xl"
    >
      <BsArrowLeftShort className="text-2xl" />
    </button>
  );
}

export default BackButton;
