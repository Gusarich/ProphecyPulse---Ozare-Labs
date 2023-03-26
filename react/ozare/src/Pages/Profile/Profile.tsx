import React, { useContext } from "react";
import Header from "../../components/Header";

import { Link, Navigate } from "react-router-dom";
import { AuthContext } from "../auth/AuthContext";

function Profile() {
  const { user } = useContext(AuthContext);

  if (!user) {
    return <Navigate replace to="/auth/login" />;
  }
  return (
    <>
      <Header showBack={false} showTonButton={false} title="Profile">
        <div className="flex flex-col items-center text-white space-y-4 font-bold">
          <div className="flex justify-center w-full">
            <img
              src={
                user.photoURL ||
                `https://ui-avatars.com/api/?name=${user.displayName}&background=0D8ABC&color=fff&size=128&rounded=true&bold=true&length=2`
              }
              alt="Profile"
              className="w-20 h-20 border-2 border-white object-cover rounded-full"
            />
          </div>
          <div className="flex flex-col text-center">
            <span className="text-2xl">{user.displayName}</span>
            <span className="text-xs">{user.email}</span>
          </div>

          <Link to="/profile/edit">
            <button className="rounded-full px-3 py-1 text-xs text-sky-500 bg-white">
              Edit
            </button>
          </Link>
        </div>
      </Header>
      <section className="grid grid-cols-2 gap-4 p-4">
        <div className="rounded-xl relative border-[1px] border-sky-500 p-4 flex flex-col">
          <span>Wins</span>
          <span className="font-bold">0</span>
        </div>
        <div className="rounded-xl relative border-[1px] border-sky-500 p-4 flex flex-col">
          <span>Loss</span>
          <span className="font-bold">0</span>
        </div>
      </section>
    </>
  );
}

export default Profile;
