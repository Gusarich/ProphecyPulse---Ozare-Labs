import React from "react";
import { Link, useLocation } from "react-router-dom";

function SideNavigation({
  navList,
}: {
  navList: { href: string; title?: string; icon: React.ReactNode }[];
}) {
  const location = useLocation();

  return (
    <div className="h-screen bg-gray-100 px-4 py-20 fixed left flex flex-col justify-start">
      {navList.map((item) => (
        <Link
          to={item.href}
          className={
            "grid grid-cols-3  items-center hover:bg-gray-300 p-2 rounded"
          }
          key={item.href}
        >
          <div
            className={`${
              location.pathname === item.href ? "text-sky-500" : "text-gray-500"
            } text-2xl pr-4 flex flex-row justify-center items-center `}
          >
            {item.icon}
          </div>
          <span
            className={`${
              location.pathname === item.href ? "text-sky-500" : "text-gray-500"
            } text-xs col-span-2`}
          >
            {item.title}
          </span>
        </Link>
      ))}
    </div>
  );
}

export default SideNavigation;
