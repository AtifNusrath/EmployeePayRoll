package com.bridgelabz;

import org.junit.jupiter.api.Test;
import java.io.IOException;
import java.nio.file.*;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.stream.IntStream;
import static org.junit.jupiter.api.Assertions.assertTrue;

public class NIOFileAPITest {
    private static String HOME = System.getProperty("user.home");
    private static String PLAY_WITH_NIO = "TempPlayGround";

    @Test
    void givenPathWhenCheckedThenConfirm() throws IOException {
        Path homePath = Paths.get(HOME);
        assertTrue(Files.exists(homePath));

        Path playPath = Paths.get(HOME + "/" + PLAY_WITH_NIO);
        if (Files.exists(playPath)) {
            www.mys.com.utils.FileUtils.deleteFile(playPath.toFile());
        }
        assertTrue(Files.notExists(playPath));

        Files.createDirectory(playPath);
        assertTrue(Files.exists(playPath));

        IntStream.range(1, 10).forEach(cntr -> {
            Path tempFile = Paths.get(playPath + "/temp" + cntr);
            assertTrue(Files.notExists(tempFile));
            try{ Files.createFile(tempFile);}
            catch (IOException e){}
            assertTrue(Files.exists(tempFile));
        });
        Files.list(playPath).filter(Files::isRegularFile).forEach(System.out::println);
        Files.newDirectoryStream(playPath).forEach(System.out::println);
        Files.newDirectoryStream(playPath, path -> path.toFile().isFile() && path.toString().startsWith("temp")).forEach(System.out::println);
    }

    @Test
    void givenDirectoryWhenWatchedListsAllTheActivities()throws IOException {
        Path dir = Paths.get(HOME+"/"+PLAY_WITH_NIO);
        Files.list(dir).filter(Files::isRegularFile).forEach(System.out::println);
        new Java8WatchServiceExample(dir).processEvents();
    }
}
