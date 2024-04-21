import { polyFont } from "@/app/layout";
import { cn } from "@/lib/utils";
import MaxWrapper from "../shared/max-wrapper";
import ListingCard from "../cards/ListingCard";
const products =[
  {
    title: "Handmade Wooden Desk Organizer",
    description: "Beautifully crafted wooden desk organizer for your workspace.",
    price: 34.99,
    image: "https://source.unsplash.com/featured/?wooden-desk"
  },
  {
    title: "Vintage Leather Messenger Bag",
    description: "Classic vintage leather messenger bag for everyday use.",
    price: 89.99,
    image: "https://source.unsplash.com/featured/?leather-bag"
  },
  {
    title: "Botanical Print Throw Pillow Cover",
    description: "Decorative botanical print throw pillow cover for your home.",
    price: 19.99,
    image: "https://source.unsplash.com/featured/?pillow-cover"
  },
  {
    title: "Handcrafted Ceramic Coffee Mug",
    description: "Handmade ceramic coffee mug perfect for your morning brew.",
    price: 14.99,
    image: "https://source.unsplash.com/featured/?ceramic-mug"
  },
  {
    title: "Bohemian Style Tassel Earrings",
    description: "Bohemian style tassel earrings to add flair to your outfit.",
    price: 9.99,
    image: "https://source.unsplash.com/featured/?earrings"
  },
  {
    title: "Rustic Farmhouse Wall Clock",
    description: "Rustic farmhouse wall clock to enhance your home decor.",
    price: 49.99,
    image: "https://source.unsplash.com/featured/?wall-clock"
  },
  {
    title: "Personalized Leather Keychain",
    description: "Customizable leather keychain for a unique touch.",
    price: 12.99,
    image: "https://source.unsplash.com/featured/?leather-keychain"
  },
  {
    title: "Minimalist Watercolor Art Print",
    description: "Minimalist watercolor art print for a modern look.",
    price: 24.99,
    image: "https://source.unsplash.com/featured/?art-print"
  },
  {
    title: "Handwoven Wool Throw Blanket",
    description: "Cozy handwoven wool throw blanket for chilly nights.",
    price: 39.99,
    image: "https://source.unsplash.com/featured/?wool-blanket"
  },
  {
    title: "Handmade Natural Soap Set",
    description: "Set of handmade natural soaps for a luxurious bath experience.",
    price: 19.99,
    image: "https://source.unsplash.com/featured/?soap-set"
  },
]



export default function ListingSection() {
  return (
    <div className="py-20">
      <MaxWrapper className="flex flex-col gap-4">
        <h1
          className={cn("text-2xl md:text-3xl font-light", polyFont.className)}>
          Some of the best Listings
        </h1>

        <div className="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 lg:grid-cols-4 xl:grid-cols-5 gap-4">
          {products.map((item: any, _key: number) => (
            <ListingCard key={_key} id={_key + Math.random()} item = {item}/>
          ))}
        </div>
      </MaxWrapper>
    </div>
  );
}
