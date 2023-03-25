import React from "react";

function Button({ onClick, title }: { onClick: () => void; title: string }) {
  return (
    <button
      onClick={onClick}
      className="text-sky-500 bg-white rounded-full bg-opacity-90 py-1 px-2 font-bold text-2xl"
    >
      {title}
    </button>
  );
}

export default Button;
