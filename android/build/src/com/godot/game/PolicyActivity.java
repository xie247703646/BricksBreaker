package com.godot.game;

import androidx.appcompat.app.AppCompatActivity;

import android.os.Bundle;
import android.widget.Toast;
import android.widget.Button;
import android.view.View;
import android.content.Intent;
import android.text.Html;
import android.text.method.LinkMovementMethod;
import android.widget.TextView;
import android.content.SharedPreferences;
import android.content.SharedPreferences.Editor;
import android.content.Context;

public class PolicyActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        SharedPreferences preference = PolicyActivity.this.getSharedPreferences("Godot",Context.MODE_PRIVATE);

        if(!preference.getBoolean("isFirstStart",true)){
//            Toast.makeText(PolicyActivity.this, "已同意隐私政策", Toast.LENGTH_SHORT).show();
            goToGodot();
            return;
        }

        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_policy);



        Button btn = findViewById(R.id.button);
        btn.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                Editor editor = preference.edit();
                editor.putBoolean("isFirstStart",false);
                editor.commit();
                goToGodot();
            }
        });
        Button btn2 = findViewById(R.id.button2);
        btn2.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                System.exit(0);
            }
        });
        String str = "欢迎您使用【BricksBreaker】！我们非常重视保护您的个人信息和隐私。\n"
        +"您可以通过<a href='https://note.youdao.com/s/UavDadxu'>《【BricksBreaker】隐私政策》</a>了解我们收集、使用、存储用户个人信息的情况，以及您所享有的相关权利。"
        +"请您仔细阅读并充分理解相关内容："
        +"1.为向您提供游戏服务，我们将依据<a href='https://note.youdao.com/s/UavDadxu'>《【BricksBreaker】隐私政策》</a>收集、使用、存储必要的信息。"
        +"2.基于您的明示授权，我们可能会申请开启您的【Android ID、传感器】设备权限，您有权拒绝或取消授权。"
        +"3.您可以访问、更正、删除您的个人信息，还可以撤回授权同意、注销账号、投诉举报以及调整其他隐私设置。"
        +"4.我们已采取符合业界标准的安全防护措施保护您的个人信息。"
        +"5.如您是未成年人，请您和您的监护人仔细阅读本隐私政策，并在征得您的监护人授权同意的前提下使用我们的服务或向我们提供个人信息。"
        +"请您阅读完整版<a href='https://note.youdao.com/s/UavDadxu'>《【BricksBreaker】隐私政策》</a>了解详细信息。 "
        +"如您同意<a href='https://note.youdao.com/s/UavDadxu'>《【BricksBreaker】隐私政策》</a>，请您点击“同意”开始使用我们的产品和服务，我们将尽全力保护您的个人信息安全。";
        TextView txt = findViewById(R.id.textView);
        txt.setText(Html.fromHtml(str));
        txt.setMovementMethod(LinkMovementMethod.getInstance());
    }

    public void goToGodot(){
        Intent intent = new Intent(PolicyActivity.this,GodotApp.class);
        startActivity(intent);
        finish();
    }
}