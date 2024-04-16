import MaxWrapper from "@/components/shared/max-wrapper";

export default function ListingPage() {
  return (
    <div className="flex-col">
      <MaxWrapper className="py-10">
        <div className="flex flex-col md:flex-row">
          <div className="flex gap-3 flex-col-reverse xl:flex-row max-h-[600px]">
            <div className="flex flex-row xl:flex-col w-full h-full overflow-x-auto overscroll-y-none xl:overscroll-x-none xl:overflow-y-auto xl:w-max gap-3">
              {Array.from({ length: 4 }).map((_, _key) => (
                <div
                  className="bg-secondary rounded h-24 aspect-[1.2]"
                  key={_key}></div>
              ))}
            </div>
            <div className="h-[600px] aspect-square bg-secondary"></div>
          </div>
        </div>
      </MaxWrapper>
    </div>
  );
}
