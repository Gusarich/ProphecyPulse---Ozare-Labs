import React from "react";
import BottomNavigation from "./BottomNavigation";

import { IoIosNotifications } from "react-icons/io";
import { RiHomeFill } from "react-icons/ri";
import { TiUser } from "react-icons/ti";
import { IoTrophy } from "react-icons/io5";
import SideNavigation from "./SideNavigation";
import useWindowSize from "../hooks/useWindowSize";
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
      icon: <IoTrophy />,
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

  return (
    <>
      {width > 768 && <SideNavigation navList={navList} />}
      {children}
      {width < 768 && <BottomNavigation navList={navList} />}
    </>
  );
}

export default Layout;
