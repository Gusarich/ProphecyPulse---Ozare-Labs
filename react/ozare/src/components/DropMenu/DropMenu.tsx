import { Menu, Transition } from "@headlessui/react";
import { Fragment } from "react";
import { BiChevronDown } from "react-icons/bi";

import { DropMenuProps } from "./types";

function DropMenu({
  title = "",
  menuItems,
  onMenuItemClick,
  className = "text-white bg-sky-500 rounded-md",
}: DropMenuProps) {
  return (
    <div className="text-left">
      <Menu as="div" className="relative inline-block text-left">
        <div>
          <Menu.Button
            className={`inline-flex w-full justify-center   px-4 py-2 text-sm font-medium  focus:outline-none focus-visible:ring-2 focus-visible:ring-white focus-visible:ring-opacity-75 ${className}`}
          >
            {title}
            <BiChevronDown
              className="ml-2 -mr-1 h-5 w-5 text-white"
              aria-hidden="true"
            />
          </Menu.Button>
        </div>
        <Transition
          as={Fragment}
          enter="transition ease-out duration-100"
          enterFrom="transform opacity-0 scale-95"
          enterTo="transform opacity-100 scale-100"
          leave="transition ease-in duration-75"
          leaveFrom="transform opacity-100 scale-100"
          leaveTo="transform opacity-0 scale-95"
        >
          <Menu.Items className="absolute left-0 mt-2 w-56 origin-top-right divide-y divide-gray-100 rounded-md bg-white shadow-lg ring-1 ring-black ring-opacity-5 focus:outline-none">
            <div className="px-1 py-1 ">
              {menuItems.map((item, index) => (
                <Menu.Item key={index}>
                  {({ active }) => (
                    <button
                      onClick={() => onMenuItemClick(item)}
                      className={`${
                        active ? "bg-sky-500 text-white" : "text-gray-900"
                      } group flex w-full items-center rounded-md px-2 py-2 text-sm`}
                    >
                      <div
                        className={`${
                          active ? "bg-sky-500 text-white" : "text-gray-900"
                        } mr-2 text-xl h-5 w-5`}
                      >
                        {item.icon}
                      </div>

                      {item.title}
                    </button>
                  )}
                </Menu.Item>
              ))}
            </div>
          </Menu.Items>
        </Transition>
      </Menu>
    </div>
  );
}

export default DropMenu;
