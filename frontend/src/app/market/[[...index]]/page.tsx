import { polyFont } from "@/app/layout";
import NFTCard from "@/components/cards/NFTCard";
import MaxWrapper from "@/components/shared/max-wrapper";
import { cn } from "@/lib/utils";
const products = [
    {
      title: "Men's Casual Shirt",
      description: "A comfortable and stylish casual shirt for men.",
      price: 29.99,
      image: "https://images.unsplash.com/photo-1602810318383-e386cc2a3ccf?q=80&w=1470&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"
    },
    {
      title: "Men's Sports Shoes",
      description: "High-performance sports shoes for men.",
      price: 49.99,
      image: "https://images.unsplash.com/photo-1460353581641-37baddab0fa2?q=80&w=1471&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"
    },
    {
      title: "Men's Watch",
      description: "A classy and elegant watch for men.",
      price: 99.99,
      image: "https://images.unsplash.com/photo-1522312346375-d1a52e2b99b3?q=80&w=1594&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"
    },
    {
      title: "Men's Jeans",
      price: 49.99,
      description: "Classic denim jeans for men",
      imageUrl: "https://images.unsplash.com/photo-1605518215584-5ba74df5dfd8?q=80&w=1632&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    },
  ]

export default function MarketPage() {
  return (
    <div className="flex-1 py-4">
      <MaxWrapper className="flex flex-col gap-4">
        <div className="flex items-end gap-3">
          <h1
            className={cn(
              "text-2xl md:text-3xl font-light",
              polyFont.className
            )}>
            Gift for Men
          </h1>
          <p className="text-xs font-normal mb-1">
            (1,000+ relevant results, with Ads)
          </p>
        </div>

        <div className="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 lg:grid-cols-4 gap-4">
          {products.map((_item : any , _key: number) => (
            <NFTCard key={_key} id={_key + Math.random()} item = {_item} />
          ))}
        </div>
      </MaxWrapper>
    </div>
  );
}
