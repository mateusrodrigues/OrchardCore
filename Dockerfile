FROM mcr.microsoft.com/dotnet/aspnet:8.0-jammy-chiseled-extra AS base
WORKDIR /app
EXPOSE 8080

FROM mcr.microsoft.com/dotnet/sdk:8.0-jammy AS build
RUN apt-get update && apt-get upgrade --yes
COPY . /app/
RUN dotnet publish /app/src/OrchardCore.Cms.Web -c Release -o /app/build/release --framework net8.0

FROM base AS final
WORKDIR /app
COPY --from=build /app/build/release .
ENTRYPOINT ["dotnet", "OrchardCore.Cms.Web.dll"]
