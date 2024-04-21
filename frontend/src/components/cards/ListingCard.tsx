import Image from "next/image";
import { AspectRatio } from "../ui/aspect-ratio";
import Link from "next/link";
import { Button } from "../ui/button";
import { Heart } from "lucide-react";

export default function ListingCard({ id, item }: { id: number, item :any }) {
  return (
    <Link
      href={`/listing/${id}`}
      className="w-full rounded-lg border shadow bg-background relative">
      <AspectRatio ratio={16 / 11} className="bg-muted">
        <Image
          src={item.image}
          alt="Photo by Drew Beamer"
          fill
          className="rounded-md object-cover"
        />
      </AspectRatio>

      <div className="flex flex-col justify-between p-3 absolute w-full h-full top-0 left-0">
        <Button
          size="icon"
          variant="secondary"
          className="rounded-full ml-auto">
          <Heart className="w-4 h-4" />
        </Button>

        <div className="py-2 px-4 text-xs font-semibold bg-background rounded-full w-max">
          USD {item.price}
          <span className="font-normal line-through ml-1">USD 16.99</span>
        </div>
      </div>
    </Link>
  );
}
