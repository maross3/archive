using System;
using System.Collections.Generic;
using System.Linq;

class RandomProblems
{
    static void Main(string[] args)
    {
        Console.WriteLine(GetLongestSubString("ooooosssslsdkdfsfhdddddddddddsfsdfsdadsafsadf"));
    }

    private static int GetLongestSubString(string s)
    {
        var characters = s.ToCharArray();
        var indexingDict = new Dictionary<char, int>();
        var left = 0;
        var right = 0;
        var currentMax = 0;

        while(right < characters.Length && left < characters.Length)
        {
            if(indexingDict.ContainsKey(characters[right])) 
                left = indexingDict[characters[right]] + 1;
            else indexingDict.Add(characters[right], right);
            
            indexingDict[characters[right]] = right;
            right++;

            var curDist = right - left;
            if (curDist > currentMax) currentMax = curDist;
        }
        return currentMax;
    }
}
