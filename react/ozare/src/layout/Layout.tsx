import React from "react";
import BottomNavigation from "./BottomNavigation";

import { IoIosNotifications } from "react-icons/io";
import { RiHomeFill } from "react-icons/ri";
import { TiUser } from "react-icons/ti";
// import { IoTrophy } from "react-icons/io5";
import SideNavigation from "./SideNavigation";
import useWindowSize from "../hooks/useWindowSize";
import Logo from "../assets/logo.png";
import { useLocation } from "react-router-dom";

function Layout({ children }: { children: React.ReactNode }) {
  const navList = [
    {
      href: "/",
      title: "Home",
      icon: <RiHomeFill />,
    },
    {
      href: "/bets",
      title: "Bets",
      icon: <img src={Logo} alt="" className="h-[24px]  " />,
    },
    {
      href: "/notifications",
      title: "Notifications",
      icon: <IoIosNotifications />,
    },
    {
      href: "/profile",
      title: "Profile",
      icon: <TiUser />,
    },
  ];
  const { width } = useWindowSize();
  const location = useLocation();

  let dontShowNav =
    location.pathname === "/auth/login" ||
    location.pathname === "/auth/register" ||
    location.pathname === "/auth/forgot" ||
    location.pathname === "/auth/reset" ||
    location.pathname === "/auth/verify" ||
    location.pathname === "/auth/verify_email";

  return (
    <>
      {width > 768 && (
        <>
          {!dontShowNav && <SideNavigation navList={navList} />}

          <div className={!dontShowNav ? "ml-[160px]" : "ml-0"}>{children}</div>
        </>
      )}

      {width < 768 && (
        <>
          <div className={!dontShowNav ? "mb-[88px]" : "mb-0"}>{children}</div>
          {!dontShowNav && <BottomNavigation navList={navList} />}
        </>
      )}
    </>
  );
}

export default Layout;
