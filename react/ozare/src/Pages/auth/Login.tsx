import React, { useContext, useEffect, useState } from "react";
import {
  getRedirectResult,
  onAuthStateChanged,
  signInWithEmailAndPassword,
  signInWithRedirect,
} from "firebase/auth";
import { auth, googleAuthProvider } from "./firebase";
import { useNavigate } from "react-router-dom";
import { FcGoogle } from "react-icons/fc";

const Login = () => {
  const navigate = useNavigate();

  const [formValues, setFormValues] = useState<{
    email: string;
    password: string;
  }>({ email: "", password: "" });
  const [error, setError] = useState<string>("");

  const handleInputChange = (event: React.ChangeEvent<HTMLInputElement>) => {
    const { name, value } = event.target;
    setFormValues((prevState) => ({ ...prevState, [name]: value }));
  };

  const handleSignIn = async (event: React.FormEvent<HTMLFormElement>) => {
    event.preventDefault();

    try {
      const userCredential = await signInWithEmailAndPassword(
        auth,
        formValues.email,
        formValues.password
      );
      const user = userCredential.user;

      return true;
    } catch (error: any) {
      setError("Wrong email or password");
      return false;
    }
  };

  const handleGoogleSignIn = async () => {
    // handle Google Sign In
    try {
      await signInWithRedirect(auth, googleAuthProvider);
    } catch (error: any) {
      setError(error.message);
    }
  };

  useEffect(() => {
    const unsubscribe = onAuthStateChanged(auth, (user) => {
      if (user) {
        navigate("/");
      }
    });

    return unsubscribe;
  }, [navigate]);

  return (
    <div className="flex flex-col w-full items-center justify-center h-screen">
      <div className="w-2/3 md:w-1/3 lg:w-1/4">
        <h1 className="text-3xl font-bold mb-8">Let's Get Started</h1>

        <form
          className="flex flex-col w-full pb-6 border-b-[1px] border-gray-100"
          onSubmit={handleSignIn}
        >
          <div className="flex flex-col mt-4">
            <label htmlFor="email" className="mb-2  text-xs text-gray-500">
              Email Address
            </label>
            <input
              type="email"
              id="email"
              name="email"
              placeholder="Enter your email address"
              value={formValues.email}
              onChange={handleInputChange}
              className="mb-4 px-8 py-4 shadow-sm  rounded-2xl bg-sky-100 text-sky-500  outline-none"
            />
          </div>

          <div className="flex flex-col mb-4">
            <label htmlFor="password" className="mb-2 text-xs text-gray-500">
              Password
            </label>
            <input
              type="password"
              id="password"
              name="password"
              placeholder="Enter your password"
              value={formValues.password}
              onChange={handleInputChange}
              className="mb-4 px-8 py-4 shadow-sm  rounded-2xl bg-sky-100 text-sky-500  outline-none"
            />
          </div>
          {error && (
            <p className="text-red-500 text-xs text-center mb-4">{error}</p>
          )}

          <button className="px-8 shadow-lg rounded-2xl py-4 bg-sky-500 text-white disabled:bg-gray-300">
            Sign In
          </button>
        </form>

        <button
          onClick={handleGoogleSignIn}
          className="px-8 w-full mt-6 flex  gap-4 flex-row justify-center items-center rounded-2xl py-4 bg-sky-50 shadow-lg text-black disabled:bg-gray-300"
        >
          <FcGoogle className="text-2xl" /> Sign In With Google
        </button>
        <div>
          <p className="text-center mt-4">
            Don't have an account?{" "}
            <a href="/auth/register" className="text-sky-500 font-bold">
              Register
            </a>
          </p>
        </div>
      </div>
    </div>
  );
};

export default Login;
