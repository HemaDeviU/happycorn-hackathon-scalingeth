import Image from "next/image";
import Link from "next/link";

export default function NFTCard({ id }: { id: number }) {
  return (
    <Link href={`/listing/${id}`} className="flex flex-col">
      <div className="w-full aspect-[1] bg-muted">
        <Image
          src="https://images.unsplash.com/photo-1712877334077-bbfb3475a597?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHw3fHx8ZW58MHx8fHx8"
          alt="Photo by Drew Beamer"
          width={330}
          height={900}
          className="rounded-md object-cover w-full h-full"
        />
      </div>

      <div className="mt-2">
        <p className="truncate text-sm font-normal">
          Lorem ipsum dolor sit amet consectetur adipisicing elit. Unde enim
          officiis sit quas officia totam, tempore iusto delectus atque aliquid,
          placeat ea explicabo ad excepturi architecto, in illo quam aliquam!
        </p>
        <p className="font-semibold">USD 22.45</p>
      </div>
    </Link>
  );
}
