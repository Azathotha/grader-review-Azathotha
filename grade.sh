CPATH='.;../lib/hamcrest-core-1.3.jar;../lib/junit-4.13.2.jar'

rm -rf student-submission
rm -rf grading-area

mkdir grading-area

git clone $1 student-submission
echo 'Finished cloning to student-submission'

# Draw a picture/take notes on the directory structure that's set up after
# getting to this point

# Then, add here code to compile and run, and do any post-processing of the
# tests

# compare file names and get feedback
find student-submission -type f -name "ListExamples.java"
# -f student-submission/ListExamples.java
if [[ -f student-submission/ListExamples.java ]]
then
    echo 'Correct file found'
else
    echo 'Wrong file or directory'
    exit 0
fi

# copy files to grading-area
cp -r student-submission/*.java *.java grading-area
echo 'Finished cloning to grading-area'

# Compile tests and the student’s code
cd grading-area/
javac -cp $CPATH *.java
java -cp $CPATH org.junit.runner.JUnitCore TestListExamples > Junit_output.txt

# check if passed
count=`grep -c FAILURES!!! Junit_output.txt`
if [[ $count -eq 0 ]]
then
    echo 'all test passed'
else
    echo "FAILURES!!!: $count tests failed" 
fi