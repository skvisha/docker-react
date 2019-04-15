#tag this step and give a name builder
FROM   node:alpine as  builder

WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
#output of this step will be build folder with static content that will go to prod env
RUN npm run build

#run phase
FROM nginx
#copy build folder from "builder" phase to this image
# --from parameter means u are copying outcome of some previous step :
# In this case app/build folder
COPY --from=builder /app/build /usr/share/nginx/html