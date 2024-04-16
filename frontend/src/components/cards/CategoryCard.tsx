import Image from "next/image";
import { AspectRatio } from "../ui/aspect-ratio";
import Link from "next/link";

export default function CategoryCard({ id }: { id: number }) {
  return (
    <Link
      href={`/market/${id}`}
      className="w-full rounded-lg border shadow bg-background">
      <AspectRatio ratio={16 / 10} className="bg-muted">
        <Image
          src="https://images.unsplash.com/photo-1588345921523-c2dcdb7f1dcd?w=800&dpr=2&q=80"
          alt="Photo by Drew Beamer"
          fill
          className="rounded-md rounded-b-none object-cover"
        />
      </AspectRatio>

      <div className="px-4 py-3">
        <p className="text-sm md:text-base font-medium">Category Name</p>
      </div>
    </Link>
  );
}
