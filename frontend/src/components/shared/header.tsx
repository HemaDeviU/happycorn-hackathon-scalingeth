import Link from "next/link";

import { AlignJustify, Search } from "lucide-react";

import {
  DropdownMenu,
  DropdownMenuContent,
  DropdownMenuItem,
  DropdownMenuTrigger,
} from "@/components/ui/dropdown-menu";
import { Input } from "@/components/ui/input";
import { Button } from "@/components/ui/button";
import happycorn from "../../../public/happycorn.png"
import MaxWrapper from "./max-wrapper";
import ConnectButton from "./ConnectButton";
import Image from "next/image";

export default function HeaderComponent() {

  return (
    <header className="w-full sticky top-0 inset-x-0 bg-background/70 backdrop-blur-sm z-10">
      <MaxWrapper className="flex items-center justify-between gap-4 py-3">
        <div className="max-w-[284px] flex-1 flex items-center gap-4">
          <Link href="/">
            <Image src={happycorn} height={300} width={500} alt="Happ-corn.png"/>
          </Link>

          {/* <DropdownMenu>
            <DropdownMenuTrigger asChild>
              <div className="flex items-center gap-2 cursor-pointer">
                <AlignJustify className="w-4 h-4" />
                <p className="text-sm font-medium">Category</p>
              </div>
            </DropdownMenuTrigger>
            <DropdownMenuContent>
              {categories.map((category) => (
                <DropdownMenuItem key={category}>{category}</DropdownMenuItem>
              ))}
            </DropdownMenuContent>
          </DropdownMenu> */}
        </div>

        {/* <div className="flex-1 h-12 rounded-full border-2 border-secondary-foreground flex items-center pr-1">
          <Input
            placeholder="Search for anything"
            className="flex-1 h-full shadow-none border-none rounded-l-full text-base"
          />
          <Button size="icon" className="rounded-full w-10 h-10">
            <Search className="w-5 h-5" />
          </Button>
        </div> */}
        <ConnectButton />

      </MaxWrapper>
    </header>
  );
}
