import Image from "next/image";
import Link from "next/link";

export default function NFTCard({ id, item }: { id: number, item : any }) {
  return (
    <Link href={`/listing/${id}`} className="flex flex-col">
      <div className="w-full aspect-[1] bg-muted">
        <Image
          src={item.image}
          alt="Photo by Drew Beamer"
          width={330}
          height={900}
          className="rounded-md object-cover w-full h-full"
        />
      </div>

      <div className="mt-2">
        <p className="truncate text-sm font-normal">
          {item.description}
        </p>
        <p className="font-semibold">USD {item.price}</p>
      </div>
    </Link>
  );
}
