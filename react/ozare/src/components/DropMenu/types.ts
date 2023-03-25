type DropMenuItem = {
  title: string;
  icon: React.ReactNode;
};

export type DropMenuProps = {
  title?: string;
  menuItems: DropMenuItem[];
  onMenuItemClick: (item: DropMenuItem) => void;
  className?: string;
};
