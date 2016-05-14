/*
 * ImageUtils.java 2011.02.15
 *
 * Copyright (c) 2010, MEI By Seok Kyun. Choi. (최석균)
 * http://syaku.tistory.com
 * 
 * GNU Lesser General Public License
 * http://www.gnu.org/licenses/lgpl.html
 */

package net.javabugs.web.common.utils;

import java.awt.Graphics2D;
import java.awt.Image;
import java.awt.image.BufferedImage;
import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;

import javax.imageio.ImageIO;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;

import net.javabugs.web.common.utils.image.AnimatedGifEncoder;
import net.javabugs.web.common.utils.image.GifDecoder;

public class ImageUtils {
  private static Logger log = Logger.getLogger(ImageUtils.class);

  public static void createThumbnail(String load,String save,String type,int w,int h) {
	  
	  try {
		  BufferedInputStream stream_file = new BufferedInputStream(new FileInputStream(load));
		  createThumbnail(stream_file,save,type,w,h);
	  } catch (Exception e) {
		  log.error(e);
	  }
	  
  }

  public static void createThumbnail(BufferedInputStream stream_file,String save,String type,int w,int h) {
    try {

    if (StringUtils.equals(StringUtils.lowerCase(type),"gif")) {
      getGifImageThumbnail(stream_file,save,type,w,h);
    } else {
      getImageThumbnail(stream_file,save,type,w,h);
    }

    } catch (Exception e) {
      log.error(e);
    }

  }

  public static void getImageThumbnail(BufferedInputStream stream_file,String save,String type,int w,int h) {

    try {
      File  file = new File(save);
      BufferedImage bi = ImageIO.read(stream_file);

      int width = bi.getWidth();
      int height = bi.getHeight();
      if (w < width) { width = w; }
      if (h < height) { height = h; }

      BufferedImage bufferIm = new BufferedImage(width, height, BufferedImage.TYPE_INT_RGB);
      Image atemp = bi.getScaledInstance(width, height, Image.SCALE_AREA_AVERAGING);

      Graphics2D  g2 = bufferIm.createGraphics();
      g2.drawImage(atemp, 0, 0, width, height, null);
      ImageIO.write(bufferIm, type, file);
    } catch (Exception e) {
      log.error(e);
    }

  }

  public static void getGifImageThumbnail(BufferedInputStream stream_file,String save,String type,int w,int h) {

      GifDecoder dec = new GifDecoder();
      AnimatedGifEncoder enc = new AnimatedGifEncoder();
      dec.read(stream_file);

      int cnt = dec.getFrameCount();

      int delay = 0;
      int width = 0;
      int height = 0;

      try{
        enc.start(save);
        enc.setRepeat(0);

        for (int i = 0; i < cnt; i++) {
        BufferedImage frame = dec.getFrame(i);
        delay = dec.getDelay(i);

        width = frame.getWidth();
        height = frame.getHeight();
        if (w < width) { width = w; }
        if (h < height) { height = h; }

        BufferedImage destimg = new BufferedImage(width, height, BufferedImage.TYPE_4BYTE_ABGR);
        Graphics2D g = destimg.createGraphics();

        g.drawImage(frame, 0, 0, width, height, null);
        enc.setDelay(delay);

        enc.addFrame(destimg);
        }

        enc.finish();
      }catch(Exception ex){
        log.error(ex);
      }
  }
  
  public static void createThumbnail(String load,String save,String type,int w) {
	  
	  try {
		  BufferedInputStream stream_file = new BufferedInputStream(new FileInputStream(load));
		  createThumbnail(stream_file,save,type,w);
	  } catch (Exception e) {
		  log.error(e);
	  }
	  
  }
  
  public static void createThumbnail(BufferedInputStream stream_file,String save,String type,int w) {
	  try {
		  
		  if (StringUtils.equals(StringUtils.lowerCase(type),"gif")) {
			  getGifImageThumbnail(stream_file,save,type,w);
		  } else {
			  getImageThumbnail(stream_file,save,type,w);
		  }
		  
	  } catch (Exception e) {
		  log.error(e);
	  }
	  
  }
  
  public static void getImageThumbnail(BufferedInputStream stream_file,String save,String type,int w) {
	  
	  try {
		  File  file = new File(save);
		  BufferedImage bi = ImageIO.read(stream_file);
		  
		  int width = bi.getWidth();
		  int height = bi.getHeight();
		  
		  double ratio = (double) height / width;
		  height = (int)(w * ratio);
		  if (w < width) { width = w; }
		  
		  BufferedImage bufferIm = new BufferedImage(width, height, BufferedImage.TYPE_INT_RGB);
		  Image atemp = bi.getScaledInstance(width, height, Image.SCALE_AREA_AVERAGING);
		  
		  Graphics2D  g2 = bufferIm.createGraphics();
		  g2.drawImage(atemp, 0, 0, width, height, null);
		  ImageIO.write(bufferIm, type, file);
	  } catch (Exception e) {
		  log.error(e);
	  }
	  
  }
  
  public static void getGifImageThumbnail(BufferedInputStream stream_file,String save,String type,int w) {
	  
	  GifDecoder dec = new GifDecoder();
	  AnimatedGifEncoder enc = new AnimatedGifEncoder();
	  dec.read(stream_file);
	  
	  int cnt = dec.getFrameCount();
	  
	  int delay = 0;
	  int width = 0;
	  int height = 0;
	  
	  try{
		  enc.start(save);
		  enc.setRepeat(0);
		  
		  for (int i = 0; i < cnt; i++) {
			  BufferedImage frame = dec.getFrame(i);
			  delay = dec.getDelay(i);
			  
			  width = frame.getWidth();
			  height = frame.getHeight();
			  
			  double ratio = (double) height / width;
			  height = (int)(w * ratio);
			  if (w < width) { width = w; }
			  
			  BufferedImage destimg = new BufferedImage(width, height, BufferedImage.TYPE_4BYTE_ABGR);
			  Graphics2D g = destimg.createGraphics();
			  
			  g.drawImage(frame, 0, 0, width, height, null);
			  enc.setDelay(delay);
			  
			  enc.addFrame(destimg);
		  }
		  
		  enc.finish();
	  }catch(Exception ex){
		  log.error(ex);
	  }
  }

  public static void main(String[] args) {
	  ImageUtils.createThumbnail("D:\\Project\\Uploads\\stylebook\\guest\\23.jpg", "D:\\Project\\Uploads\\stylebook\\guest\\thumb\\23.jpg", "jpg", 120);
  }

}
