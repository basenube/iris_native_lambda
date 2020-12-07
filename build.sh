clear
echo -e "Creating the root directory for the function...\n\n\n\n"
mkdir iris_native_lambda
sleep 10
clear
echo -e "Now we are going to switch directories to the root...\n\n\n\n"
pwd
cd iris_native_lambda
sleep 10
clear
echo -e "Lesgo grab the Python wheel package from the quickstart...\n\n\n\n"
wget https://github.com/intersystems/quickstarts-python/raw/master/Solutions/nativeAPI_wheel/irisnative-1.0.0-cp34-abi3-linux_x86_64.whl
sleep 10
clear
echo -e "Wheels are zips, so just unzip it...\n\n\n\n"
unzip irisnative-1.0.0-cp34-abi3-linux_x86_64.whl
sleep 10
clear
echo -e "Lets take a quick look and see our folder structure so far...\n\n\n\n"
tree .
sleep 10
clear
echo -e "Looking good!  Now we need the secret sauce, which is the lambda function code itself and some supporting conf files...\n\n\n\n"
cp ../examples/index.py .
cp ../examples/connection.config .
sleep 10
clear
echo -e "Lets take a look at the file structure now, it should be complete\n\n\n\n"
tree .
sleep 10
clear
echo -e "now zip it all up!\n\n\n\n"
zip -r9 ../iris_native_lambda.zip *
sleep 10
clear
echo -e "Done creating the lambda function package, lets put it up in S3 so we can further create the lambda\n\n\n\n"
sleep 10
cd ..
pwd
# aws s3 mb s3://iris-native-bucket
aws s3 cp iris_native_lambda.zip s3://iris-native-bucket
sleep 10
clear
echo -e "All Set!\n\n\n\n\n\n\n\n\n\n\n"