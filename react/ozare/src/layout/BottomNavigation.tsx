import React from "react";
import { Link, useLocation } from "react-router-dom";
function BottomNavigation({
  navList,
}: {
  navList: { href: string; title: string; icon: React.ReactNode }[];
}) {
  const location = useLocation();
  return (
    <nav className="fixed py-4 z-10 bg-gray-100 bottom-0 w-full items-center flex flex-row justify-evenly">
      {navList.map((item) => (
        <Link
          to={item.href}
          className={"flex flex-col items-center"}
          key={item.href}
        >
          <div
            className={`${
              location.pathname === item.href ||
              location.pathname.includes(`${item.href}/`)
                ? "text-sky-500"
                : "text-gray-500"
            } text-2xl`}
          >
            {item.icon}
          </div>
          <span
            className={`${
              location.pathname === item.href ||
              location.pathname.includes(`${item.href}/`)
                ? "text-sky-500"
                : "text-gray-500"
            } text-xs`}
          >
            {item.title}
          </span>
        </Link>
      ))}
    </nav>
  );
}

export default BottomNavigation;
